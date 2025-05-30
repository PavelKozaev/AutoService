using Microsoft.EntityFrameworkCore;

namespace AutoServiceAPI.Models
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public virtual DbSet<UnfinishedRepairView> UnfinishedRepairs { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UnfinishedRepairView>(entity =>
            {
                entity.HasNoKey();
                entity.ToView("UnfinishedRepairs");
            });
        }
    }

    [Keyless]
    public class UnfinishedRepairView
    {        
        public string MasterName { get; set; }
        public string CarBrand { get; set; }
        public string CarModel { get; set; }
        public string LicensePlate { get; set; }
        public string ClientName { get; set; }
        public string FaultDescription { get; set; }
        public DateTime StartDate { get; set; }
        public decimal Cost { get; set; }
        public decimal MasterTotal { get; set; }
    }
}
