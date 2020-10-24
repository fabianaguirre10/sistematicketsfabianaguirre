using DataAccess;
using DataAccess.Entidades;
using DataObject.EntidadesDao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Business.EntidadesBusiness
{
   public class PersonaBusiness
    {
        readonly PersonaDao personaDao;

        public PersonaBusiness(TicketContext ticketContext)
        {
            personaDao = new PersonaDao(ticketContext);
        }
        public List<Persona> GetActivePersonas()
        {
            return personaDao.GetPersonas();
        }
        public async Task<int> PutPersonas(Persona persona)
        {
            return await personaDao.PutPersonas(persona);
        }
    }
}
