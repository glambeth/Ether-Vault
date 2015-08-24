contract timeVault {
	struct Member {
		address addr;
		uint amount;
		uint blockNumberDeposited;
		uint blockWithdrawlNumber;
	}

	Member[] public members;
	uint public fundsStored;
	uint public numDeposits;

	function timeVault() {
		fundsStored = 0;
		numDeposits = 0;
	}

	function sendAssets(uint blockWithDrawlNumber) {
		Member newMember;
		newMember.addr = msg.sender;
		newMember.amount = msg.value;
		newMember.blockNumberDeposited = block.number;
		newMember.blockWithdrawlNumber = blockWithDrawlNumber;
		members[numDeposits] = newMember;
		numDeposits++;
	}

	function retrieveAssets() { 
		for (uint i =0; i < numDeposits; ++i) {
			if (members[i].blockWithdrawlNumber >= block.number) {
				members[i].addr.send(members[i].amount);
			}
		}
	}
}
