contract timeVault {
	struct Member {
		address addr;
		uint amount;
		uint blockNumberDeposited;
		unit blockWithdrawlNumber;
	}

	Member[] public members;
	unit public fundsStored;
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
		newMember.blockWithDrawlNumber = blockWithDrawlNumber;
		members[numDeposits] = newMember;
		numDeposits++;
	}

	function retrieveAssets() { 
		for (uint i =0; i < numDeposits; ++i) {
			if (members[i].blockWithdrawlNumber >= block.number) {
				members[i].addr.send(members[i].addr.amount);
			}
		}
	}
}