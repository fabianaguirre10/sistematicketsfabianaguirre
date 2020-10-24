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
    public class TicketBusiness
    {
        readonly PersonaDao personaDao;
        readonly TicketsDao ticketDao;

        public TicketBusiness(TicketContext ticketContext)
        {
            ticketDao = new TicketsDao(ticketContext);
        }
        public async Task<bool> PostTicketsAsync(Tickets ticket)
        {
            return await ticketDao.PostTicketAsync(ticket);
        }
        public async Task<bool> PutTicketsAsync(Tickets ticket)
        {
            return await ticketDao.PutTicketAsync(ticket);
        }
        public int ObtenerTiempoEsperasAsync(int tipocola)
        {
            return  ticketDao.ObtenerTiempoEsperaAsync(tipocola);
        }
        public int MaxOrdens(int tipocola)
        {
            return ticketDao.MaxOrdenAsync(tipocola);
        }
        public Tickets obobtenerparaseratendido(int tipocola)
        {
            return ticketDao.obtenerparaseratendido(tipocola);
        }
        public async Task ActualizarAtencionAsync()
        {
             await ticketDao.ActualizarAtencionAsync();

        }
    }
}
