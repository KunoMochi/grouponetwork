<template>
    <div class="login">
        <h1>Welcome back!</h1>
        <div class="username">
            <p><label> Username</label></p>
            <input class="username-box" id="username">
        </div>
        <div class="password">
            <p><label>Password</label></p>
            <input class="password-box" id="password">
        </div>
        <div>
            <button>Login</button> | 
            <router-link to="/signup">Create an account</router-link>
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

    a {
        font-size: small;
        font-weight: bold;
        color: white;
        text-decoration: none;
    }
</style>