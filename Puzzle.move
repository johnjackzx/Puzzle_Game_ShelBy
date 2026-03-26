module puzzle::shelby_puzzle {
    use std::signer;
    use std::vector;
    use aptos_framework::account;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin; // or your custom token

    struct PuzzleState has key {
        board: vector<u8>,        // 16 tiles (0 = empty)
        moves: u64,
        solved: bool,
        player: address,
        puzzle_id: u64,           // links to Shelby blob ID or hash
    }

    struct HighScore has key {
        scores: vector<HighScoreEntry>,
    }

    struct HighScoreEntry has store, drop {
        player: address,
        moves: u64,
        timestamp: u64,
    }

    const PUZZLE_SIZE: u64 = 16;
    const ENTRY_FEE: u64 = 1000000; // 0.001 APT example

    public entry fun start_puzzle(account: &signer, puzzle_id: u64) {
        let player = signer::address_of(account);
        coin::transfer<AptosCoin>(account, @treasury, ENTRY_FEE); // simple fee

        let board = vector::empty<u8>();
        // Initialize solved state then shuffle (simple random or fixed shuffle logic)
        let i = 0;
        while (i < PUZZLE_SIZE) {
            vector::push_back(&mut board, (i as u8));
            i = i + 1;
        };
        // TODO: proper shuffle using randomness (use aptos_framework::randomness if available)

        let state = PuzzleState {
            board,
            moves: 0,
            solved: false,
            player,
            puzzle_id,
        };
        move_to(account, state);
    }

    public entry fun make_move(account: &signer, from_pos: u64, to_pos: u64) acquires PuzzleState {
        let state = borrow_global_mut<PuzzleState>(signer::address_of(account));
        // Validate move (adjacent to empty tile), swap tiles, increment moves
        // ...
        state.moves = state.moves + 1;

        if (is_solved(&state.board)) {
            state.solved = true;
            // Record high score logic
        };
    }

    // Helper: check if solved
    fun is_solved(board: &vector<u8>): bool {
        let i = 0;
        while (i < PUZZLE_SIZE - 1) {
            if (*vector::borrow(board, i) != (i as u8)) { return false; };
            i = i + 1;
        };
        true
    }

    // Add functions for high scores, NFT mint on solve, etc.
}
