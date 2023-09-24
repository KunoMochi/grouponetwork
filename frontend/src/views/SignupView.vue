<template>
    <div class="signup">
        <h1>This is the Signup page</h1>
        <div class="username">
            <p>New Username</p>
            <input class="username-box">
        </div>
        <div class="password">
            <p>New Password</p>
            <input class="password-box">
        </div>
        <div class="password">
            <p>Confirm Password</p>
            <input class="confirm-password-box">
        </div>
        <div>
            <button>Existing User</button>
            <button>Create Account</button>
        </div>
    </div>
</template>

<style lang="scss" scoped>
    div .signup {
        width: 100%;
        text-align: center;
        padding: 1rem;
    }

    .username, .password {
        font-weight: bold;
        margin-top: 2rem;
    }
    
    input {
        font-size: medium;
        width: 30rem;
    }
</style>