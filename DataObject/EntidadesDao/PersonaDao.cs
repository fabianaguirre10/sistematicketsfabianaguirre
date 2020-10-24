using DataAccess;
using DataAccess.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataObject.EntidadesDao
{
    public class PersonaDao : ADao
    {
        public PersonaDao(TicketContext ticketContext) : base(ticketContext)
        {
        }
        public List<Persona> GetPersonas()
        {
            return Context.Persona.ToList();
        }
        public async Task<int> PutPersonas(Persona persona)
        {
           
            try
            {
               
                Context.Add(persona);
                await  Context.SaveChangesAsync();
                return persona.Id;
            }
            catch (Exception ex)
            {
                return 0;
            }

        }
    }
}
