using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections;
using System.Xml;
using System.IO;

namespace Shared.Components
{

    public class AtomReader
    {
        private SecureXmlReader secReader = null;
        private SecuritySettings SecuritySettings { get; set; }
        public StateSettings StateSettings { get; set; }
        private Stack<Queue<Entry>> stackQueue = new Stack<Queue<Entry>>();
        private XmlReader reader = null;

        private string latestEntryId = String.Empty;
        private string nextFeed = String.Empty;

        bool idFound = false;

        private int feedDeepth = 0;
        private int feedMax = 10;

        /// <summary>
        /// Reads archive type Atom+xml feeds
        /// </summary>
        /// <param name="uri">Recent Atom feed</param>
        /// <param name="stateSettings">State settings</param>
        /// <param name="securitysettings">Security settings</param>
        public AtomReader(string uri, StateSettings stateSettings, SecuritySettings securitysettings, int max)
        {

            StateSettings = stateSettings;
            SecuritySettings = securitysettings;

            feedMax = max;

            if (stateSettings.Id == String.Empty)
                feedMax = Int32.MaxValue;


            nextFeed = uri;

            secReader = new SecureXmlReader(securitysettings);

            if (stateSettings.Id != String.Empty && StateSettings.WorkingFeed != String.Empty)
            {
                MoveToFirstFeed(stateSettings.WorkingFeed);
            }
            else if (stateSettings.Id == String.Empty && StateSettings.WorkingFeed == String.Empty)
            {
                throw  new InvalidConfiguration("Both Entry Id (state file) and First feed (configuration) cannot be empty!");
            }
            else if (stateSettings.Id == String.Empty)
            {
                if (StateSettings.FindFirst == true)
                {
                    //Find all feeds from first feed in specified atom feed
                    MoveToFirstFeed(stateSettings.WorkingFeed);

                }
                else
                {
                    //Find all feeds beginning with specified feed
                    this.reader = secReader.Create(stateSettings.WorkingFeed);
                }
            }
            else
            {
                MoveToFirstFeed(uri);

            }




        }

        public AtomReader(string uri, StateSettings stateSettings, SecuritySettings securitysettings):this(uri, stateSettings, securitysettings,10)
        {
           
        }


        /// <summary>
        ///  Finds the first feed and inits the inner reader
        /// </summary>
        private void MoveToFirstFeed(string uri)
        {
            string id = String.Empty;
            Dictionary<string, string> links = new Dictionary<string, string>();
            //continue from reader where prev- is missing
            this.reader = secReader.Create(uri);

            this.feedDeepth++;

            if (feedDeepth > feedMax)
                throw new MaxDeepthException(feedMax);

            while (reader.Read())
            {
                if (reader.LocalName == "link")
                {
                    AddToLinks(links);
                }

                if (reader.LocalName == "id" && (StateSettings.Id != String.Empty))
                {
                    id = reader.ReadElementContentAsString();

                    if (id == StateSettings.Id)
                    {
                        //Find first feed with specified entry id
                        StateSettings.WorkingFeed = links["self"];
                        IdFound = true;
                        this.reader = secReader.Create();
                        return;
                    }
                }

                ///When searching for first feed with specified entry id
                if (reader.LocalName == "entry" && (StateSettings.Id == String.Empty))
                    break;
            }
          
            if (links.ContainsKey("prev-archive") == true)
            {
                MoveToFirstFeed(links["prev-archive"]);
            }
            
            if (links.ContainsKey("via") == true)
            {
                StateSettings.WorkingFeed = links["via"];
            }
            else if (links.ContainsKey("self") == true)
            {
                StateSettings.WorkingFeed = links["self"];
            }

        }
        public Feed NextFeed()
        {
            DateTime latest = DateTime.Now;
            Dictionary<string, string> links = new Dictionary<string, string>();
            Feed feed = new Feed();
          

            idFound = false;

            if (nextFeed == String.Empty)
                return feed;

            while (reader.Read())
            {
                //read links
                if (reader.LocalName == "updated")
                {

                    feed.Updated = DateTime.Parse(reader.ReadInnerXml());
                    
                }

                if (reader.LocalName == "link")
                {
                    AddToLinks(links);
                }

                if (reader.LocalName == "entry")
                    break;


            }

            //Check if recent is updated
            if (latest == StateSettings.LastUpdated)//|| links.ContainsKey("next-archive") == false
                return feed;

           


            do
            {
                ProcessFeed(feed);
            } while (reader.ReadToFollowing("entry"));

            
               

            if (links.ContainsKey("via"))
            {
                feed.Uri = links["via"];
            }
            else if (links.ContainsKey("self"))
            {
                feed.Uri = links["self"];
            }

                if (links.TryGetValue("next-archive", out nextFeed))
            {
                this.reader = secReader.Create(nextFeed);
            }


            /*
           if (links.ContainsKey("prev-archive"))
           {


               reader = SecureXmlReader.Create(links["prev-archive"], this.SecuritySettings);
               reader.MoveToContent();
               Entry();
              
            }
             */

            return feed;


        }


        /// <summary>
        /// Specifies if saved id is found
        /// </summary>
        public bool IdFound
        {
            get
            {
                return idFound;
            }
            set
            {
                if (idFound == false)
                    idFound = value;
            }

        }



        private void AddToLinks(Dictionary<string, string> links)
        {
            var rel = reader.GetAttribute("rel");
            var href = reader.GetAttribute("href");

            if (links.ContainsKey(rel) == false)
                links.Add(rel, href);
        }
        /// <summary>
        /// Processes an feed Entry
        /// </summary>
        /// <param name="entries">Queue with entries from an Atom feed</param>
        /// <returns>true/false if latest entry id has been found</returns>
        private void ProcessFeed(Feed feed)
        {

            //latestEntry
            do
            {
                if (reader.LocalName == "entry")
                {
                    Entry entry = new Entry();

                    do
                    {
                        if (ProcessEntry(entry) == true)
                            break;

                    } while (reader.Read());

                    feed.Entries.Push(entry);


                }

            } while (reader.Read());
        }


        private bool ProcessEntry(Entry entry)
        {
            bool done = false;

            switch (reader.LocalName)
            {
                case "id":

                    entry.Id = reader.ReadElementContentAsString();
                    return ProcessEntry(entry);
                case "updated":
                    entry.Updated = reader.ReadElementContentAsDateTime();
                    return ProcessEntry(entry);
                case "content":
                    string content = reader.ReadInnerXml();

                    if (entry.Id == StateSettings.Id)
                    {
                        // entries.Clear();
                        IdFound = true;
                    }

                    entry.Content = content.Trim();
                    done = true;
                    break;



            }

            return done;

        }
    
    }
}
