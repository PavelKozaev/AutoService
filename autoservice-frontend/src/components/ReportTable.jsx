import React, { useState } from 'react';
import axios from 'axios';
import Select from 'react-select';
import moment from 'moment';

const months = Array.from({ length: 12 }, (_, i) => ({
  value: i + 1,
  label: moment().month(i).format('MMMM'),
}));

const years = Array.from({ length: 5 }, (_, i) => {
  const year = new Date().getFullYear() - i;
  return { value: year, label: year };
});

const ReportTable = () => {
  const [month, setMonth] = useState(null);
  const [year, setYear] = useState(null);
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(false);

  const fetchData = async () => {
    setLoading(true);
    try {
      const response = await axios.get('http://localhost:5210/api/v1/reports/unfinished-repairs',  {
        params: {
          month: month?.value,
          year: year?.value,
        },
      });
      setData(response.data);
    } catch (error) {
      alert('Ошибка загрузки данных');
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ padding: 20 }}>
      <div style={{ display: 'flex', gap: 10, marginBottom: 20 }}>
        <Select
          options={months}
          value={month}
          onChange={setMonth}
          placeholder="Выберите месяц"
        />
        <Select
          options={years}
          value={year}
          onChange={setYear}
          placeholder="Выберите год"
        />
        <button onClick={fetchData} disabled={loading}>
          {loading ? 'Загрузка...' : 'Показать отчет'}
        </button>
      </div>

      {loading && <p>Загрузка данных...</p>}

      {!loading && data.length > 0 && (
        <>
          <h3>Общая стоимость работ: {data.reduce((sum, r) => sum + r.cost, 0).toFixed(2)} ₽</h3>
          <table border="1" cellPadding="8" cellSpacing="0" style={{ width: '100%', borderCollapse: 'collapse' }}>
            <thead>
              <tr>                
                <th>Мастер</th>
                <th>Марка</th>
                <th>Модель</th>
                <th>Госномер</th>
                <th>Клиент</th>                
                <th>Неисправность</th>
                <th>Дата начала</th>
                <th>Стоимость</th>    
                <th>Общая стоимость для мастера</th>                      
                <th>Процент загрузки</th>
              </tr>
            </thead>
            <tbody>
              {data.map((row, index) => (
                <tr key={index}>                  
                  <td>{row.masterName}</td>
                  <td>{row.carBrand}</td>
                  <td>{row.carModel}</td>
                  <td>{row.licensePlate}</td>
                  <td>{row.clientName}</td>                  
                  <td>{row.faultDescription}</td>
                  <td>{new Date(row.startDate).toLocaleDateString()}</td>
                  <td>{row.cost.toFixed(2)} ₽</td>    
                  <td>{row.masterTotal}</td>                                
                  <td>{row.workloadPercentage ? row.workloadPercentage.toFixed(2) + '%' : '-'}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </>
      )}

      {!loading && data.length === 0 && <p>Нет данных.</p>}
    </div>
  );
};

export default ReportTable;