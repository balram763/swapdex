struct Token:
    balance as u128;

struct User:
    address as public key;
    wallet as Token;

function initialize_user() -> User:
    cast 0u128 into wallet as Token;
    output address as public key, wallet as Token as User;

function deposit(user: User, amount: u128) -> User:
    require amount > 0, "Deposit amount must be greater than 0";
    user.wallet.balance += amount;
    output user;

function swap(userA: User, userB: User, amountA: u128, amountB: u128) -> (User, User):
    require amountA > 0 && amountB > 0, "Swap amounts must be greater than 0";

    // Check if userA has sufficient balance
    require userA.wallet.balance >= amountA, "Insufficient balance for swap";

    // Perform the swap
    userA.wallet.balance -= amountA;
    userB.wallet.balance += amountA;

    userB.wallet.balance -= amountB;
    userA.wallet.balance += amountB;

    output userA, userB;
