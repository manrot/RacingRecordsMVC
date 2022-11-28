using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using RacingRecordsMVC.Models;

namespace RacingRecordsMVC.Controllers
{
    public class ReportesController : Controller
    {
        private readonly RacingRecordsContext _context;

        public ReportesController(RacingRecordsContext context)
        {
            _context = context;
        }

        // GET: Reportes
        public async Task<IActionResult> Index()
        {
            var racingRecordsContext = _context.EjecucionCarreras.Include(e => e.IdCompetidorNavigation);

            if (racingRecordsContext.Count() == 10)
            {
                return View(await racingRecordsContext.ToListAsync());
            }
            else {
                return RedirectToAction("ErrorReport", "Home");
                
            }

            

           // return View(await racingRecordsContext.ToListAsync());
        }

        // GET: Reportes/Details/5
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null || _context.EjecucionCarreras == null)
            {
                return NotFound();
            }

            var ejecucionCarrera = await _context.EjecucionCarreras
                .Include(e => e.IdCompetidorNavigation)
                .FirstOrDefaultAsync(m => m.IdCompetencia == id);
            if (ejecucionCarrera == null)
            {
                return NotFound();
            }

            return View(ejecucionCarrera);
        }

        // GET: Reportes/Create
        public IActionResult Create()
        {
            ViewData["IdCompetidor"] = new SelectList(_context.Competidors, "IdCompetidor", "IdCompetidor");
            return View();
        }

        // POST: Reportes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("IdCompetencia,IdCompetidor,Minutos,Segundos,NumeroCompetidor")] EjecucionCarrera ejecucionCarrera)
        {
            if (ModelState.IsValid)
            {
                _context.Add(ejecucionCarrera);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["IdCompetidor"] = new SelectList(_context.Competidors, "IdCompetidor", "IdCompetidor", ejecucionCarrera.IdCompetidor);
            return View(ejecucionCarrera);
        }

        // GET: Reportes/Edit/5
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null || _context.EjecucionCarreras == null)
            {
                return NotFound();
            }

            var ejecucionCarrera = await _context.EjecucionCarreras.FindAsync(id);
            if (ejecucionCarrera == null)
            {
                return NotFound();
            }
            ViewData["IdCompetidor"] = new SelectList(_context.Competidors, "IdCompetidor", "IdCompetidor", ejecucionCarrera.IdCompetidor);
            return View(ejecucionCarrera);
        }

        // POST: Reportes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(long id, [Bind("IdCompetencia,IdCompetidor,Minutos,Segundos,NumeroCompetidor")] EjecucionCarrera ejecucionCarrera)
        {
            if (id != ejecucionCarrera.IdCompetencia)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(ejecucionCarrera);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!EjecucionCarreraExists(ejecucionCarrera.IdCompetencia))
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
            ViewData["IdCompetidor"] = new SelectList(_context.Competidors, "IdCompetidor", "IdCompetidor", ejecucionCarrera.IdCompetidor);
            return View(ejecucionCarrera);
        }

        // GET: Reportes/Delete/5
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null || _context.EjecucionCarreras == null)
            {
                return NotFound();
            }

            var ejecucionCarrera = await _context.EjecucionCarreras
                .Include(e => e.IdCompetidorNavigation)
                .FirstOrDefaultAsync(m => m.IdCompetencia == id);
            if (ejecucionCarrera == null)
            {
                return NotFound();
            }

            return View(ejecucionCarrera);
        }

        // POST: Reportes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            if (_context.EjecucionCarreras == null)
            {
                return Problem("Entity set 'RacingRecordsContext.EjecucionCarreras'  is null.");
            }
            var ejecucionCarrera = await _context.EjecucionCarreras.FindAsync(id);
            if (ejecucionCarrera != null)
            {
                _context.EjecucionCarreras.Remove(ejecucionCarrera);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool EjecucionCarreraExists(long id)
        {
          return _context.EjecucionCarreras.Any(e => e.IdCompetencia == id);
        }
    }
}
