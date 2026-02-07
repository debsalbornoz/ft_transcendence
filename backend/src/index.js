const express = require('express');
const cors = require('cors');

// Cria o aplicativo
const app = express();
app.use(cors());

// Porta configurável via variáveis de ambiente
const port = process.env.PORT || 8000;

// Endpoint simples de saúde para verificar se a API está no ar
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Inicia o servidor
app.listen(port, () => {
  console.log(`Backend rodando na porta ${port}`);
});