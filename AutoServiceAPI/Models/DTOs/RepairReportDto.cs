namespace AutoServiceAPI.Models.DTOs
{
    public class RepairReportDto
    {        
        /// <summary>
        /// Мастер
        /// </summary>
        public string MasterName { get; set; }

        /// <summary>
        /// Мрака
        /// </summary>
        public string CarBrand { get; set; }

        /// <summary>
        /// Моедль
        /// </summary>
        public string CarModel { get; set; }

        /// <summary>
        /// Госномер
        /// </summary>
        public string LicensePlate { get; set; }

        /// <summary>
        /// Клиент
        /// </summary>
        public string ClientName { get; set; }

        /// <summary>
        /// Неисправность
        /// </summary>
        public string FaultDescription { get; set; }

        /// <summary>
        /// Дата начала
        /// </summary>
        public DateTime StartDate { get; set; }

        /// <summary>
        /// Стоимость работы
        /// </summary>
        public decimal Cost { get; set; }

        /// <summary>
        /// Общая стоимость работ мастера
        /// </summary>
        public decimal MasterTotal { get; set; }

        /// <summary>
        /// Процент загруженности мастера
        /// </summary>
        public decimal? WorkloadPercentage { get; set; }
    }
}
