using AutoServiceAPI.Models;
using AutoServiceAPI.Models.DTOs;
using ClosedXML.Excel;
using Microsoft.EntityFrameworkCore;

namespace AutoServiceAPI.Services
{
    public class ReportService : IReportService
    {
        private readonly AppDbContext _context;

        public ReportService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RepairReportDto>> GetUnfinishedRepairsReport(int? year, int? month)
        {
            var query = _context.UnfinishedRepairs.AsQueryable();

            if (year.HasValue && month.HasValue)
            {
                query = query.Where(r => r.StartDate.Year == year && r.StartDate.Month == month);
            }
            else if (year.HasValue)
            {
                query = query.Where(r => r.StartDate.Year == year);
            }

            var result = await query
                .OrderBy(r => r.StartDate)
                .ThenBy(r => r.MasterName)
                .ThenBy(r => r.CarBrand)
                .Select(r => new RepairReportDto
                {
                    StartDate = r.StartDate,
                    MasterName = r.MasterName,
                    CarBrand = r.CarBrand,
                    CarModel = r.CarModel,
                    LicensePlate = r.LicensePlate,
                    ClientName = r.ClientName,
                    FaultDescription = r.FaultDescription,
                    Cost = r.Cost,
                    MasterTotal = r.MasterTotal,
                    GrandTotal = r.GrandTotal
                })
                .ToListAsync();

            if (year.HasValue && month.HasValue)
            {
                var totalCost = result.Sum(r => r.Cost);
                if (totalCost > 0)
                {
                    var masters = result.Select(r => r.MasterName).Distinct();
                    foreach (var master in masters)
                    {
                        var masterCost = result.Where(r => r.MasterName == master).Sum(r => r.Cost);
                        var percentage = (masterCost / totalCost) * 100;
                        foreach (var item in result.Where(r => r.MasterName == master))
                        {
                            item.WorkloadPercentage = percentage;
                        }
                    }
                }
            }

            return result;
        }

        public async Task<byte[]> ExportUnfinishedRepairsToExcel(int? year, int? month)
        {
            var data = await GetUnfinishedRepairsReport(year, month);

            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add("Unfinished Repairs");

                var headers = new[]
                {
                "Мастер", "Марка", "Модель", "Госномер",
                "Клиент", "Неисправность", "Дата начала", "Стоимость", "Процент загрузки"
            };

                for (int i = 0; i < headers.Length; i++)
                {
                    worksheet.Cell(1, i + 1).Value = headers[i];
                }

                int row = 2;
                foreach (var item in data)
                {
                    worksheet.Cell(row, 1).Value = item.MasterName;
                    worksheet.Cell(row, 2).Value = item.CarBrand;
                    worksheet.Cell(row, 3).Value = item.CarModel;
                    worksheet.Cell(row, 4).Value = item.LicensePlate;
                    worksheet.Cell(row, 5).Value = item.ClientName;
                    worksheet.Cell(row, 6).Value = item.FaultDescription;
                    worksheet.Cell(row, 7).Value = item.StartDate;
                    worksheet.Cell(row, 8).Value = item.Cost;
                    worksheet.Cell(row, 9).Value = item.WorkloadPercentage.HasValue
                        ? item.WorkloadPercentage.Value / 100
                        : 0;
                    row++;
                }

                worksheet.Range("A1:I1").Style.Font.Bold = true;
                worksheet.Range("H2:H" + row).Style.NumberFormat.Format = "#,##0.00";
                worksheet.Range("I2:I" + row).Style.NumberFormat.Format = "0.00%";
                worksheet.Columns().AdjustToContents();

                using (var stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    return stream.ToArray();
                }
            }
        }
    }
}
