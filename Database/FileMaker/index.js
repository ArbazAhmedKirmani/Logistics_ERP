const fs = require("fs").promises;
const path = require("path");

async function readNamesFromFiles(nameFiles) {
  let names = [];

  for (file of nameFiles) {
    const data = await fs.readFile(file);
    names.push(data);
  }

  return names;
}

async function getNameFiles(folderName) {
  let nameFiles = [];

  const items = await fs.readdir(folderName, { withFileTypes: true });

  for (item of items) {
    nameFiles.push(path.join(folderName, item.name));
  }
  return nameFiles;
}

async function main() {
  const dir = __dirname.toString().slice(0, -9);
  const spFolder = path.join(dir, "stored-procedures");
  const funcFolder = path.join(dir, "functions");

  // stored procedures
  const spFiles = await getNameFiles(spFolder);
  const spNames = await readNamesFromFiles(spFiles);

  const spFilePath = path.join(dir, "all-procedures.sql");

  await fs.writeFile(spFilePath, spNames.join(" \ngo \n \n"), {
    flag: "a"
  });

  // functions
  const funcFiles = await getNameFiles(funcFolder);
  const funcNames = await readNamesFromFiles(funcFiles);

  const funcFilePath = path.join(dir, "all-functions.sql");

  await fs.writeFile(funcFilePath, funcNames.join(" \ngo \n \n"), {
    flag: "a"
  });
}

main();
