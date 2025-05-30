import React, { useState } from 'react';
import './App.css';
import ReportTable from './components/ReportTable';

function App() {
  return (
    <div className="App">
      <h1>Автосервис - Отчет по незавершенным ремонтам</h1>
      <ReportTable />
    </div>
  );
}

export default App;