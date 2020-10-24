using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataObject
{
    public abstract class ADao
    {
      

        protected ADao(TicketContext ticketContext)
        {
            Context = ticketContext;
        }

        public TicketContext Context { get; }
    }
}
