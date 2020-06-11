pragma solidity ^0.4.24;

import "./../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./../node_modules/openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "./../node_modules/openzeppelin-solidity/contracts/lifecycle/Destructible.sol";

contract MAGEtoken is Ownable, StandardToken, Destructible {
    string public constant name = "MAGE";
    uint256 public constant decimals = 18;
    string public constant symbol = "MGE";

    address public depositWalletAddress;
    uint256 public weiRaised;
    using SafeMath for uint256;
    address public tokenLockedContract;

    constructor(address _tokenLockedContract) public {
        owner = msg.sender;
        totalSupply_ = 1000000000 * (10**decimals);
        balances[owner] = 150000000 * (10**decimals);
        depositWalletAddress = owner;
        emit Transfer(address(0), owner, balances[owner]);

        tokenLockedContract = _tokenLockedContract;
        balances[tokenLockedContract] = 850000000 * (10**decimals);
        emit Transfer(
            address(0),
            tokenLockedContract,
            balances[tokenLockedContract]
        );
    }

    function() public {
        revert();
    }

    event updateTokenLockedContract(
        address indexed oldLockedContract,
        address indexed newLockedContract,
        uint256 tokensTransfered
    );

    function updateLockedContract(address _tokenLockedContract)
        public
        onlyOwner
    {
        require(isContract(_tokenLockedContract));
        uint256 tokensTotalInPrevContract = balances[tokenLockedContract];
        balances[_tokenLockedContract] = balances[_tokenLockedContract].add(
            balances[tokenLockedContract]
        );
        balances[tokenLockedContract] = balances[tokenLockedContract].sub(
            balances[tokenLockedContract]
        );
        emit updateTokenLockedContract(
            tokenLockedContract,
            _tokenLockedContract,
            tokensTotalInPrevContract
        );
        tokenLockedContract = _tokenLockedContract;
    }

    // assemble the given address bytecode. If bytecode exists then the _addr is a
    // contract.
    function isContract(address _addr)
        internal
        view
        returns (bool is_contract)
    {
        uint256 length;
        assembly {
            //retrieve the size of the code on target address, this needs assembly
            length := extcodesize(_addr)
        }
        return (length > 0);
    }

    //This buy event is used only for ico duration
    event Buy(address _from, uint256 _ethInWei, string userId);

    function buy(string userId) public payable {
        require(msg.value > 0);
        require(msg.sender != address(0));
        weiRaised += msg.value;
        forwardFunds();
        emit Buy(msg.sender, msg.value, userId);
    } //end of buy

    /**
     * @dev Determines how ETH is stored/forwarded on purchases.
     */
    function forwardFunds() internal {
        depositWalletAddress.transfer(msg.value);
    }

    function initiateTransaction(address[] recievers, uint256[] tokens)
        public
        onlyOwner
    {
        for (uint256 i = 0; i < recievers.length; i++) {
            transfer(recievers[i], tokens[i]);
        }
    }

    function changeDepositWalletAddress(address newDepositWalletAddr)
        public
        onlyOwner
    {
        require(newDepositWalletAddr != 0);
        depositWalletAddress = newDepositWalletAddr;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        super.transfer(_to, _value);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        super.transferFrom(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        super.approve(_spender, _value);
    }

    function increaseApproval(address _spender, uint256 _addedValue)
        public
        returns (bool)
    {
        super.increaseApproval(_spender, _addedValue);
    }
}
