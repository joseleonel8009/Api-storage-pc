const storage = "C:/Users/anleo/Videos";
if (!storage) {
  console.error('Storage path not defined');
  process.exit(1);
}

module.exports = storage;