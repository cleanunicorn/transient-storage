contract Transient {
    uint256 constant TRANSIENT_NUMBER_SLOT = 0x00;

    function increment() public {
        // Define a local variable
        uint256 n;

        assembly {
            // Load the current transient value of the number variable
            n := tload(TRANSIENT_NUMBER_SLOT)

            // Increment the transient value
            n := add(n, 1)

            // Store the transient value back
            tstore(TRANSIENT_NUMBER_SLOT, n)
        }
    }

    function number_transient() public view returns (uint256) {
        // Define a local variable
        uint256 n;

        assembly {
            // Load the current transient value of the number variable
            n := tload(TRANSIENT_NUMBER_SLOT)
        }

        // Return the transient value
        return n;
    }
}
