<template>
    <div class="login">
        <h1>This is the Login page</h1>
        <div class="username">
            <p>Username</p>
            <input class="username-box">
        </div>
        <div class="password">
            <p>Password</p>
            <input class="password-box">
        </div>
        <div>
            <button>Login</button>
            <button>Create Account</button>
        </div>
    </div>
</template>

<style lang="scss" scoped>
    div .login {
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