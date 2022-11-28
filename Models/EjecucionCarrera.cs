using System;
using System.Collections.Generic;

namespace RacingRecordsMVC.Models;

public partial class EjecucionCarrera
{
    public long IdCompetencia { get; set; }

    public long IdCompetidor { get; set; }

    public int Minutos { get; set; }

    public int Segundos { get; set; }

    public int NumeroCompetidor { get; set; }

    public virtual Competidor IdCompetidorNavigation { get; set; } = null!;
}
