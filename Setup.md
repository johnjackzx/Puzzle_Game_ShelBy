## 🚀 Quick Start

### 1. Prerequisites
- [Aptos CLI](https://aptos.dev/tools/aptos-cli/) installed
- Node.js 18+ and pnpm/yarn/npm
- Aptos wallet with testnet APT
- Shelby account (fund with APT + ShelbyUSD via faucets)

### 2. Clone & Setup
```bash
git clone <your-repo-url>
cd shelby-slide-puzzle

Deploy the Move Contract (Testnet):
cd puzzle_game  # or wherever your Move sources are
aptos move compile
aptos move publish --network testnet

Upload Puzzle Images to Shelby:
# Example using Shelby CLI (see docs.shelby.xyz/tools/cli)
shelby upload --file ./puzzles/cat.png \
  --metadata '{"name": "Mysterious Cat", "difficulty": "medium"}'
