import { createStore } from 'vuex'
import axios from 'axios'

export default createStore({
  state: {
    authToken: '',
    userId: '',
    username: '',
    isAuth: false,
    showModal1: false,
    showModal2: false
  },
  getters: {
    getAuth(state) {
      return state.authToken
    },
    getUserId(state) {
      return state.userId
    },
    getUserName(state) {
      return state.username
    }
  },
  mutations: {
    loginUser (state, payload) {
      state.authToken = payload.token
      state.isAuth = true
      state.userId = payload.userId
      state.username = payload.username
    },
    logoutUser (state) {
      state.authToken = ''
      state.userId = ''
      state.username = ''
      state.isAuth = false
    },
    changeModalState (state, payload) {
      // console.log(payload)
      state.showModal1 = payload.showModal1
      state.showModal2 = payload.showModal2
    }
  },
  actions: {
    onSignUp(context, data) {
      let modal1 = false
      let modal2 = false
      if(data.username) {
        if(data.password == data.confPass && data.password != undefined) {
          // console.log('username: ' + this.username + ', password: ' + this.password)

          //Create user account
          axios.post('http://localhost:3000/api/auth/signup', {
              username: data.username,
              password: data.password
            }).catch(err => {
              console.log(err)
            })

          //Sign-in user right after account creation
          axios.post('http://localhost:3000/api/auth/login', {
            username: data.username,
            password: data.password
          }).then((response) => {
            // console.log(response.data)
            context.commit('loginUser', {
              token: response.data.token,
              userId: response.data.userId,
              username: data.username
            })
          }).catch(err => {
            console.log(err)
          })
        } else {
          modal2 = true
        }
      } else {
        modal1 = true
      }
      context.commit('changeModalState', {showModal1: modal1, showModal2: modal2})
    },
    onLogin(context, data) {
      let modal1 = false
      let modal2 = false
      if(data.username) {
        if(data.password != undefined) {
          // console.log('username: ' + data.username + ', password: ' + data.password)
          axios.post('http://localhost:3000/api/auth/login', {
              username: data.username,
              password: data.password
            }).then((response) => {
              // console.log(response.data)
              context.commit('loginUser', {
                token: response.data.token,
                userId: response.data.userId,
                username: data.username
              })
            }).catch(err => {
              console.log(err)
            })
        } else {
          modal2 = true
        }
      } else {
        modal1 = true
      }
      context.commit('changeModalState', {showModal1: modal1, showModal2: modal2})
    },
    onLogOut(context) {
      context.commit('logoutUser')
    }
  },
  modules: {
  }
})
