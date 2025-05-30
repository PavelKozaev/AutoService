namespace AutoServiceAPI.Models.DTOs
{
    public class RepairReportDto
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
        public decimal GrandTotal { get; set; }
        public decimal? WorkloadPercentage { get; set; }
    }
}
