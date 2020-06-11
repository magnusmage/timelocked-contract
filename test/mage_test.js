var Token = artifacts.require("magetoken");

var TokenName = "MAGE";
var Symbol = "MGE";
var TokenSupply = 1000000000;
var Decimals = 18;


expect = require("chai").expect;

var totalSupply;


contract("Token contract", function (accounts) {

    describe("Check Smart Contract instance", function () {
        it("catch an instance of tokenContract", function () {
            return Token
                .deployed()
                .then(function (instance) {
                    TokenInstance = instance;
                    console.log("tokenContract = " + TokenInstance.address);
                });
        });
        it("Saving totalSupply", function () {
            return TokenInstance
                .totalSupply()
                .then(function (res) {
                    console.log("totalSupply = " + res.toString());
                    totalSupply = res.toString();
                    expect(res.toString())
                        .to
                        .be
                        .equal((TokenSupply * (Math.pow(10, Decimals))).toString());
                });
        });
    });

    describe("Check initial parameters", function () {
        it("Check Token name", function () {
            return TokenInstance
                .name
                .call()
                .then(function (res) {
                    console.log("Token name = " + res.toString());
                    expect(res.toString())
                        .to
                        .be
                        .equal(TokenName);
                })
        })
        it("Check Token Symbol", function () {
            return TokenInstance
                .symbol
                .call()
                .then(function (res) {
                    console.log("Token Symbol = " + res.toString());
                    expect(res.toString())
                        .to
                        .be
                        .equal(Symbol);
                })
        })
        it("check Token Decimals", function () {
            return TokenInstance
                .decimals
                .call()
                .then(function (res) {
                    console.log("Token decimals = " + res.toString());
                    expect(parseInt(res.toString()))
                        .to
                        .be
                        .equal(Decimals);
                })
        })
    })

});