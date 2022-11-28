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
    public class CompetidorsController : Controller
    {
        private readonly RacingRecordsContext _context;

        public CompetidorsController(RacingRecordsContext context)
        {
            _context = context;
        }

        // GET: Competidors
        public async Task<IActionResult> Index()
        {
              return View(await _context.Competidors.ToListAsync());
        }

        // GET: Competidors/Details/5
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null || _context.Competidors == null)
            {
                return NotFound();
            }

            var competidor = await _context.Competidors
                .FirstOrDefaultAsync(m => m.IdCompetidor == id);
            if (competidor == null)
            {
                return NotFound();
            }

            return View(competidor);
        }

        // GET: Competidors/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Competidors/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("IdCompetidor,Identificacion,Nombre,Apellido1,Apellido2")] Competidor competidor)
        {
            if (ModelState.IsValid)
            {
                _context.Add(competidor);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(competidor);
        }

        // GET: Competidors/Edit/5
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null || _context.Competidors == null)
            {
                return NotFound();
            }

            var competidor = await _context.Competidors.FindAsync(id);
            if (competidor == null)
            {
                return NotFound();
            }
            return View(competidor);
        }

        // POST: Competidors/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(long id, [Bind("IdCompetidor,Identificacion,Nombre,Apellido1,Apellido2")] Competidor competidor)
        {
            if (id != competidor.IdCompetidor)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(competidor);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!CompetidorExists(competidor.IdCompetidor))
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
            return View(competidor);
        }

        // GET: Competidors/Delete/5
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null || _context.Competidors == null)
            {
                return NotFound();
            }

            var competidor = await _context.Competidors
                .FirstOrDefaultAsync(m => m.IdCompetidor == id);
            if (competidor == null)
            {
                return NotFound();
            }

            return View(competidor);
        }

        // POST: Competidors/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            if (_context.Competidors == null)
            {
                return Problem("Entity set 'RacingRecordsContext.Competidors'  is null.");
            }
            var competidor = await _context.Competidors.FindAsync(id);
            if (competidor != null)
            {
                _context.Competidors.Remove(competidor);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool CompetidorExists(long id)
        {
          return _context.Competidors.Any(e => e.IdCompetidor == id);
        }
    }
}
