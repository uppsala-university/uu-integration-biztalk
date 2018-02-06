using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BizTalk.Adapter.Atom
{
    public class BatchInfo
    {
        
        /// <summary>
        /// Called when the BizTalk Batch has been submitted.  If all the messages were submitted (good or suspended)
        /// we delete the files from the folder
        /// </summary>
        /// <param name="overallStatus"></param>
        internal void OnBatchComplete(bool overallStatus)
        {
           
            if (overallStatus == true) //Batch completed
            {

                Message.Complete();
                
            }
        }
    }

}
