using System;
using System.Collections.Generic;

namespace RacingRecordsMVC.Models;

public partial class Competidor
{
    public long IdCompetidor { get; set; }

    public string Identificacion { get; set; } = null!;

    public string Nombre { get; set; } = null!;

    public string Apellido1 { get; set; } = null!;

    public string Apellido2 { get; set; } = null!;

    public string NombreCompleto
    {
        get
        {
            return Nombre + " " + Apellido1 + " " + Apellido2;
        }
    }

    public virtual ICollection<EjecucionCarrera> EjecucionCarreras { get; } = new List<EjecucionCarrera>();
}
