const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 80;

// Простая страница
app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="ru">
    <head>
      <meta charset="UTF-8">
      <title>Web App</title>
      <style>
        body { font-family: Arial; text-align: center; margin-top: 50px; }
        h1 { color: #2c3e50; }
      </style>
    </head>
    <body>
      <h1>🚀 Hello from Yandex Cloud!</h1>
      <p>Ваше приложение успешно запущено в Docker на ВМ.</p>
      <p><strong>DB_HOST:</strong> ${process.env.DB_HOST || 'not set'}</p>
    </body>
    </html>
  `);
});

app.listen(PORT, () => {
  console.log(`Сервер запущен на порту ${PORT}`);
});