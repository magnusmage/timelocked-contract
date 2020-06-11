var MageToken = artifacts.require("magetoken");
var tokenTimeLock = artifacts.require("TimeLockedToken");

var airDropLockTokenAddress = 'ETHEREUM-ADDRESS';
var marketingLockTokenAddress = 'ETHEREUM-ADDRESS';
var advisorLockTokenAddress = 'ETHEREUM-ADDRESS';
var developerLockTokenAddress = 'ETHEREUM-ADDRESS';
var ecoSystemLockTokenAddress = 'ETHEREUM-ADDRESS';
module.exports = function (deployer) {
    deployer
        .deploy(
            tokenTimeLock,
            airDropLockTokenAddress,
            marketingLockTokenAddress,
            advisorLockTokenAddress,
            developerLockTokenAddress,
            ecoSystemLockTokenAddress
        )
        .then(instance => {
            deployer
                .deploy(MageToken,instance.address)
                .then(contractAddress => {
                  
                });
        });

};