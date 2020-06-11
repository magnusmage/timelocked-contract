pragma solidity ^ 0.4 .23;

import "./../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol";
import "./../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";



/**
 * @title TimeTokenLock
 * @dev A token holder contract that can release its token balance gradually like a
 * typical vesting scheme, with a cliff and vesting period. Optionally revocable by the
 * owner.
 */
contract TimeTokenLock is Ownable{
    using SafeMath for uint256;
    // ERC20 basic token contract being held
    ERC20Basic public token;


    //vesting addresses
    address public airDropLockTokenAddress; 
    address public marketingLockTokenAddress;
    address public advisorLockTokenAddress;
    address public developerLockTokenAddress;
    address public ecoSystemLockTokenAddress;

    uint256 public lockTimeForNextRelease; 
    uint256 public tokenLockTimeStart;

    uint256 maxTokenLocked;
    uint256 public totalLockedTokensRemain;

    event unlockTokensInYear(uint256 totalTokensUnlocked);
    uint256 yearTime = 2 minutes;
    constructor (
        address _airDropLockTokenAddress, 
        address _marketingLockTokenAddress,
        address _advisorLockTokenAddress,
        address _developerLockTokenAddress,
        address _ecoSystemLockTokenAddress
    )public {
        owner = msg.sender;
        airDropLockTokenAddress =  _airDropLockTokenAddress;
        marketingLockTokenAddress = _marketingLockTokenAddress;
        advisorLockTokenAddress =  _advisorLockTokenAddress;
        developerLockTokenAddress = _developerLockTokenAddress;
        ecoSystemLockTokenAddress = _ecoSystemLockTokenAddress;

        tokenLockTimeStart = block.timestamp;
        lockTimeForNextRelease = tokenLockTimeStart + yearTime;

        maxTokenLocked = 850000000 ether;
        totalLockedTokensRemain = maxTokenLocked;
        
    }

    function balanceOfContract ( ) public view returns (uint256) {
        return token.balanceOf(this);
    }
    function updateTokenAddress(address _token)public onlyOwner {
        require(isContract(_token));
        token = ERC20Basic(_token);
    }

      // assemble the given address bytecode. If bytecode exists then the _addr is a
    // contract.
    function isContract(address _addr)internal view returns(bool is_contract) {
        uint length;
        assembly {
            //retrieve the size of the code on target address, this needs assembly
            length := extcodesize(_addr)
        }
        return (length > 0);
    }


    function getYearDiffInterval ( ) public  view returns(uint256){
           
            return (lockTimeForNextRelease - tokenLockTimeStart)/ yearTime;
    }
    /**
    * @notice 
    */
    function release() public onlyOwner {
        require(block.timestamp>lockTimeForNextRelease);
        uint256 yearDiff = getYearDiffInterval();
        if(yearDiff<6){
            releaseBeforeTime(yearDiff);
        }else{
            releaseAfterTime();
        }
    }
    function releaseAfterTime() internal {
        require(totalLockedTokensRemain>0);
        uint256 tokensToUnlockThisYear = (totalLockedTokensRemain * 10) /100;
        uint256 tokensForEcoSystem = (tokensToUnlockThisYear * 50) /100;
        uint256 tokensForDeveloperCommunity = (tokensToUnlockThisYear * 20) /100;
        uint256 tokensForMarketing = (tokensToUnlockThisYear * 10) /100;
        uint256 tokensForAirDropToUnlock = (tokensToUnlockThisYear * 20) /100;
        
        
        token.transfer(airDropLockTokenAddress, tokensForAirDropToUnlock);
        token.transfer(marketingLockTokenAddress, tokensForMarketing);
        token.transfer(developerLockTokenAddress, tokensForDeveloperCommunity);
        token.transfer(ecoSystemLockTokenAddress, tokensForEcoSystem);


        emit unlockTokensInYear(tokensToUnlockThisYear);
        totalLockedTokensRemain = totalLockedTokensRemain.sub(tokensToUnlockThisYear);
        lockTimeForNextRelease = lockTimeForNextRelease.add(yearTime); //now will next year release call

     
    }
    function releaseBeforeTime( uint256 yearDiff) internal  {
        if(yearDiff == 1){
            token.transfer(airDropLockTokenAddress, (5100000 ether));
            token.transfer(marketingLockTokenAddress, (9900000 ether));
            token.transfer(advisorLockTokenAddress, (37500000 ether));
            uint256 sumTotalUnlocked =  (5100000 ether)  +  (9900000 ether) + (37500000 ether);
            emit unlockTokensInYear(sumTotalUnlocked);
            totalLockedTokensRemain = totalLockedTokensRemain.sub(sumTotalUnlocked);
            lockTimeForNextRelease = lockTimeForNextRelease.add(yearTime); //now will next year release call
            
        }else if(yearDiff == 2) {
            token.transfer(airDropLockTokenAddress, (9700000 ether));
            token.transfer(marketingLockTokenAddress, (12800000 ether));
            token.transfer(advisorLockTokenAddress, (65000000 ether));
            sumTotalUnlocked =  (9700000 ether)  +  (12800000 ether) + (65000000 ether);
            emit unlockTokensInYear(sumTotalUnlocked);
            totalLockedTokensRemain = totalLockedTokensRemain.sub(sumTotalUnlocked);
            lockTimeForNextRelease = lockTimeForNextRelease.add(yearTime); //now will next year release call
        }else if (yearDiff == 3) {
            token.transfer(airDropLockTokenAddress, (11100000 ether));
            token.transfer(marketingLockTokenAddress, (7700000 ether));
            token.transfer(advisorLockTokenAddress, (60000000 ether));
            sumTotalUnlocked =  (11100000 ether)  +  (7700000 ether) + (60000000 ether);
            emit unlockTokensInYear(sumTotalUnlocked);
            totalLockedTokensRemain = totalLockedTokensRemain.sub(sumTotalUnlocked);
            lockTimeForNextRelease = lockTimeForNextRelease.add(yearTime); //now will next year release call
        } else if (yearDiff == 4) {
            token.transfer(airDropLockTokenAddress, (12300000 ether));
            token.transfer(marketingLockTokenAddress, (7700000 ether));
            token.transfer(advisorLockTokenAddress, (50000000 ether));
            sumTotalUnlocked =  (12300000 ether)  +  (7700000 ether) + (50000000 ether);
            emit unlockTokensInYear(sumTotalUnlocked);
            totalLockedTokensRemain = totalLockedTokensRemain.sub(sumTotalUnlocked);
            lockTimeForNextRelease = lockTimeForNextRelease.add(yearTime); //now will next year release call
        }else if (yearDiff == 5) {
            token.transfer(airDropLockTokenAddress, (11900000 ether));
            token.transfer(marketingLockTokenAddress, (11900000 ether));
            token.transfer(advisorLockTokenAddress, (37500000 ether));
            sumTotalUnlocked =  (11900000 ether)  +  (11900000 ether) + (37500000 ether);
            emit unlockTokensInYear(sumTotalUnlocked);
            totalLockedTokensRemain = totalLockedTokensRemain.sub(sumTotalUnlocked);
            lockTimeForNextRelease = lockTimeForNextRelease.add(yearTime); //now will next year release call
        } 
    }
}
