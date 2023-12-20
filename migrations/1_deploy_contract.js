const SportMinter = artifacts.require("SportMinter");

module.exports = function (deployer) {
  deployer.deploy(SportMinter);
};
