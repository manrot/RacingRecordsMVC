using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace RacingRecordsMVC.Models;

public partial class RacingRecordsContext : DbContext
{
    public RacingRecordsContext()
    {
    }

    public RacingRecordsContext(DbContextOptions<RacingRecordsContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Competidor> Competidors { get; set; }

    public virtual DbSet<EjecucionCarrera> EjecucionCarreras { get; set; }




    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Competidor>(entity =>
        {
            entity.HasKey(e => e.IdCompetidor);

            entity.ToTable("Competidor");

            entity.Property(e => e.Apellido1)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Apellido2)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Identificacion)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<EjecucionCarrera>(entity =>
        {
            entity.HasKey(e => e.IdCompetencia);

            entity.ToTable("EjecucionCarrera");

            entity.HasOne(d => d.IdCompetidorNavigation).WithMany(p => p.EjecucionCarreras)
                .HasForeignKey(d => d.IdCompetidor)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_EjecucionCarrera_Competidor");
        });

      

        

        

        

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
