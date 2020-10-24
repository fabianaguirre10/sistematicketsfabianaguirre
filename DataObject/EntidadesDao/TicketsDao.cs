using DataAccess;
using DataAccess.Entidades;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataObject.EntidadesDao
{
   public  class TicketsDao : ADao
    {
        public TicketsDao(TicketContext ticketContext) : base(ticketContext)
        {
        }
        public async Task<bool> PostTicketAsync(Tickets tickets)
        {
            try
            {
                Context.Add(tickets);
                await Context.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        
        }
        public async Task<bool> PutTicketAsync(Tickets tickets)
        {
            try
            {
                
                await Context.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public int ObtenerTiempoEsperaAsync(int tipocola)
        {
            try
            {
                var ticket = Context.Tickets.Include(t => t.Persona).Where(x => x.estado.Equals("P") && x.tipocola == tipocola).Sum(y => y.tipocola);
                return ticket;
            }catch(Exception e)
            {
                return 1;
            }
        }

        public Tickets obtenerparaseratendido(int tipocola)
        {
            try
            {
                var ticket = Context.Tickets.Include(t => t.Persona).Where(x => x.estado.Equals("P") && x.tipocola == tipocola).Min(y => y.orden);
                var entidad= Context.Tickets.Include(t => t.Persona).Where(x => x.estado.Equals("P") && x.tipocola == tipocola && x.orden == ticket).FirstOrDefault();
                return entidad;
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public async Task ActualizarAtencionAsync()
        {
            var ticket = Context.Tickets.Include(t => t.Persona).Where(x => x.estado.Equals("P")).ToList();
            foreach(var t in ticket)
            {
              
                if (t.tipocola == 2)
                {
                    if (obtenerminutos(t.fechainicio)> 2)
                    {
                        t.estado = "A";
                        Context.Update(t);
                        await Context.SaveChangesAsync();
                    }
                   
                }
                if (t.tipocola == 3)
                {
                    if (obtenerminutos(t.fechainicio) > 3)
                    {
                        t.estado = "A";
                        Context.Update(t);
                        await Context.SaveChangesAsync();
                    }
                    
                }


            }

        }
        public int obtenerminutos(DateTime t)
        {
            DateTime fechaActual = DateTime.Now;
            var minutos=0;
            minutos = (fechaActual - t).Minutes;      
            return minutos;
        }


        public int MaxOrdenAsync(int tipocola)
        {
            try
            {
                 var ticket = Context.Tickets.Include(t => t.Persona).Where(x => x.estado.Equals("P") && x.tipocola == tipocola).Max(y => y.orden);
                return ticket + 1;
            }
            catch (Exception e)
            {
                return 1;
            }
        }

   }
}
