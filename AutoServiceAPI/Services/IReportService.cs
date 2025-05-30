using AutoServiceAPI.Models.DTOs;

namespace AutoServiceAPI.Services
{
    public interface IReportService
    {
        Task<IEnumerable<RepairReportDto>> GetUnfinishedRepairsReport(int? year, int? month);
        Task<byte[]> ExportUnfinishedRepairsToExcel(int? year, int? month);
    }
}
