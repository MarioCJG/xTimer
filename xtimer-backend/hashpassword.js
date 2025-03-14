const bcrypt = require('bcryptjs');

// Tomar la contraseña como argumento desde la línea de comandos
const password = process.argv[2];

// Verificar que se haya ingresado una contraseña
if (!password) {
  console.error('❌ Debes proporcionar una contraseña.');
  process.exit(1);
}

// Generar hash
bcrypt.hash(password, 10, (err, hash) => {
  if (err) {
    console.error('❌ Error al generar hash:', err);
    process.exit(1);
  }
  console.log(`✔️ Contraseña en texto plano: "${password}"`);
  console.log(`🔐 Hash generado: ${hash}`);
});
