<template>
    <form class="signup" v-on:submit.prevent="onSignUp({ username: username, password: password, confPass: confPass})">
        <h1>Create an Account</h1>
        <div class="username">
            <p>New Username</p>
            <input v-model="username" class="username-box" id="username" />
        </div>
        <div class="password">
            <p><label for="password">New Password</label></p>
            <input v-model="password" type="password" class="password-box" id="password" />
        </div>
        <div class="password">
            <p><label for="password">Confirm Password</label></p>
            <input v-model="confPass" type="password" class="confirm-password-box" />
        </div>
        <div class="username-error" v-show="showModal1">
            <p>Username is required!</p>
        </div>
        <div class="pass-error" v-show="showModal2">
            <p>Password does not match!</p>
        </div>
        <div>
            <router-link to="/login">Existing User?</router-link> | 
            <button type="submit">Create Account</button>
        </div>
    </form>
</template>

<script>
import { mapState, mapActions, mapGetters } from 'vuex'

export default {
    data() {
        return {
            username: this.username,
            password: this.password,
            confPass: this.confPass
        }
    },
    computed: {
        ...mapState(['showModal1','showModal2']),
        ...mapGetters(['getAuth','getUserId'])
    },
    watch: {
        getAuth() {
            this.$router.push('/')
        }
    },
    methods: {
        ...mapActions(['onSignUp'])
    }
}
</script>

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

    .username-error, .pass-error {
        color: red;
    }

    a {
        font-size: small;
        font-weight: bold;
        color: white;
        text-decoration: none;
    }
</style>