using AutoServiceAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace AutoServiceAPI.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    public class ReportsController : ControllerBase
    {
        private readonly IReportService _reportService;

        public ReportsController(IReportService reportService)
        {
            _reportService = reportService;
        }

        /// <summary>
        /// Gets unfinished repairs report
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        [HttpGet("unfinished-repairs")]
        public async Task<IActionResult> GetUnfinishedRepairs([FromQuery] int? year, [FromQuery] int? month)
        {
            try
            {
                var result = await _reportService.GetUnfinishedRepairsReport(year, month);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        /// <summary>
        /// Exports unfinished repairs report to Excel
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        [HttpGet("unfinished-repairs/export")]
        public async Task<IActionResult> ExportUnfinishedRepairs(
        [FromQuery] int? year,
        [FromQuery] int? month)
        {
            try
            {
                var excelBytes = await _reportService.ExportUnfinishedRepairsToExcel(year, month);

                string fileName = $"UnfinishedRepairs_{year?.ToString() ?? "all"}_{month?.ToString() ?? "all"}_{DateTime.Now:yyyyMMddHHmmss}.xlsx";

                return File(
                    excelBytes,
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                    fileName);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
