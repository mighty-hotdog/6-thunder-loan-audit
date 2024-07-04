**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [events-maths](#events-maths) (1 results) (Low)
 - [reentrancy-benign](#reentrancy-benign) (2 results) (Low)
 - [reentrancy-events](#reentrancy-events) (1 results) (Low)
 - [unused-import](#unused-import) (1 results) (Informational)
## events-maths
Impact: Low
Confidence: Medium
 - [ ] ID-0
[ThunderLoan.updateFlashLoanFee(uint256)](src/protocol/ThunderLoan.sol#L265-L270) should emit an event for: 
	- [s_flashLoanFee = newFee](src/protocol/ThunderLoan.sol#L269) 

src/protocol/ThunderLoan.sol#L265-L270


## reentrancy-benign
Impact: Low
Confidence: Medium
 - [ ] ID-1
Reentrancy in [ThunderLoan.flashloan(address,IERC20,uint256,bytes)](src/protocol/ThunderLoan.sol#L181-L229):
	External calls:
	- [assetToken.updateExchangeRate(fee)](src/protocol/ThunderLoan.sol#L204)
	State variables written after the call(s):
	- [s_currentlyFlashLoaning[token] = true](src/protocol/ThunderLoan.sol#L208)

src/protocol/ThunderLoan.sol#L181-L229


 - [ ] ID-2
Reentrancy in [ThunderLoan.flashloan(address,IERC20,uint256,bytes)](src/protocol/ThunderLoan.sol#L181-L229):
	External calls:
	- [assetToken.updateExchangeRate(fee)](src/protocol/ThunderLoan.sol#L204)
	- [assetToken.transferUnderlyingTo(receiverAddress,amount)](src/protocol/ThunderLoan.sol#L209)
	- [receiverAddress.functionCall(abi.encodeCall(IFlashLoanReceiver.executeOperation,(address(token),amount,fee,msg.sender,params)))](src/protocol/ThunderLoan.sol#L211-L222)
	State variables written after the call(s):
	- [s_currentlyFlashLoaning[token] = false](src/protocol/ThunderLoan.sol#L228)

src/protocol/ThunderLoan.sol#L181-L229


## reentrancy-events
Impact: Low
Confidence: Medium
 - [ ] ID-3
Reentrancy in [ThunderLoan.flashloan(address,IERC20,uint256,bytes)](src/protocol/ThunderLoan.sol#L181-L229):
	External calls:
	- [assetToken.updateExchangeRate(fee)](src/protocol/ThunderLoan.sol#L204)
	Event emitted after the call(s):
	- [FlashLoan(receiverAddress,token,amount,fee,params)](src/protocol/ThunderLoan.sol#L206)

src/protocol/ThunderLoan.sol#L181-L229


## unused-import
Impact: Informational
Confidence: High
 - [ ] ID-4
The following unused import(s) in src/interfaces/IFlashLoanReceiver.sol should be removed:
	-import { IThunderLoan } from "./IThunderLoan.sol"; (src/interfaces/IFlashLoanReceiver.sol#4)

