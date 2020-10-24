using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DataAccess;
using DataAccess.Entidades;
using webticketsfabian.Utils;
using Business.EntidadesBusiness;

namespace webticketsfabian.Controllers
{
    public class TicketsController : Controller
    {
        private readonly TicketContext _context;
        private readonly TicketBusiness ticketBusiness;
        private readonly PersonaBusiness personaBusiness;


        public TicketsController(TicketContext context)
        {
            _context = context;
            ticketBusiness = new TicketBusiness(_context);
            personaBusiness = new PersonaBusiness(_context);
        }

        //Getvue
        [HttpGet]
        public async Task<JsonResult> GetVueAsync()
        {
            try
            {
                await ticketBusiness.ActualizarAtencionAsync();
                var model = _context.Tickets.Include(t => t.Persona).Where(y=> y.estado=="P");
                JSonConvertUtil.Convert(model);
                return Json(model);
            }
            catch (Exception e)
            {
                return null;
            }
        }
        [HttpGet]
        public IActionResult IndexProceso()
        {
            try
            {
                return View();
            }
            catch (Exception e)
            {
               
                return RedirectToAction("Index");
            }

        }

        [HttpPost]
        public async Task<JsonResult> AtenderticketAsync(String idoperacion)
        {
            try
            {
                Tickets tickets = new Tickets();
                tickets = ticketBusiness.obobtenerparaseratendido(Convert.ToInt32(idoperacion));
                tickets.estado = "A";
                Boolean rsult = await ticketBusiness.PutTicketsAsync(tickets);
                return Json(rsult);
            }
            catch (Exception ex)
            {

                return null;
            }
        }

        [HttpPost]
        public async Task<JsonResult> GurdarPersonticketAsync(String idpersona, String nombre)
        {
            try
            {
                Tickets tickets = new Tickets();
                Persona persona = new Persona();
                persona.idpersona = idpersona;
                persona.nombre = nombre;
                tickets.idpersona= await personaBusiness.PutPersonas(persona);

                int tiempoespera2 = ticketBusiness.ObtenerTiempoEsperasAsync(2);
                int tiempoespera3 = ticketBusiness.ObtenerTiempoEsperasAsync(3);
                if (tiempoespera2 >= tiempoespera3)
                    tickets.tipocola = 3;
                else
                    tickets.tipocola = 2;
                int maxorden = ticketBusiness.MaxOrdens(tickets.tipocola);
                tickets.orden = maxorden;
                tickets.estado = "P";
                tickets.fechainicio = DateTime.Now;

                Boolean rsult= await ticketBusiness.PostTicketsAsync(tickets);

                return Json(rsult);
            }
            catch (Exception ex)
            {
               
                return null;
            }
        }

        // GET: Tickets
        public async Task<IActionResult> Index()
        {
            var ticketContext = _context.Tickets.Include(t => t.Persona);
            return View(await ticketContext.ToListAsync());
        }

        // GET: Tickets/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var tickets = await _context.Tickets
                .Include(t => t.Persona)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (tickets == null)
            {
                return NotFound();
            }

            return View(tickets);
        }

        // GET: Tickets/Create
        public IActionResult Create()
        {
            ViewData["idpersona"] = new SelectList(_context.Persona, "Id", "Id");
            return View();
        }

        // POST: Tickets/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,tipocola,estado,orden,idpersona")] Tickets tickets)
        {
            if (ModelState.IsValid)
            {
                _context.Add(tickets);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["idpersona"] = new SelectList(_context.Persona, "Id", "Id", tickets.idpersona);
            return View(tickets);
        }

        // GET: Tickets/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var tickets = await _context.Tickets.FindAsync(id);
            if (tickets == null)
            {
                return NotFound();
            }
            ViewData["idpersona"] = new SelectList(_context.Persona, "Id", "Id", tickets.idpersona);
            return View(tickets);
        }

        // POST: Tickets/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,tipocola,estado,orden,idpersona")] Tickets tickets)
        {
            if (id != tickets.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(tickets);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TicketsExists(tickets.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["idpersona"] = new SelectList(_context.Persona, "Id", "Id", tickets.idpersona);
            return View(tickets);
        }

        // GET: Tickets/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var tickets = await _context.Tickets
                .Include(t => t.Persona)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (tickets == null)
            {
                return NotFound();
            }

            return View(tickets);
        }

        // POST: Tickets/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var tickets = await _context.Tickets.FindAsync(id);
            _context.Tickets.Remove(tickets);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool TicketsExists(int id)
        {
            return _context.Tickets.Any(e => e.Id == id);
        }
    }
}
