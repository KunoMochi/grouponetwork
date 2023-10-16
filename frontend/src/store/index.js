import { createStore } from 'vuex'
import axios from 'axios'

const commentModule = {
  state: {
    title: '',
    message: '',
    timestamp: ''
  },
  getters: {
    
  },
  mutations: {
    storeQuery(state, payload) {
      state.query = payload.query
    }
  },
  actions: {
    postComment(context, data) {
      console.log(data)
      if(context.getters.getIsAuth) {
        console.log(context.getters.getIsAuth)
        if(data.content && data.title) {
          axios.post('http://localhost:3000/api/addComment', {
            userId: data.userId,
            title: data.title,
            postContent: data.content,
            timestamp: data.timestamp
          }).catch(err => {
            console.log(err)
          })
        } else {
          context.commit('changeMessage', {message: 'Please fill in title and comment fields!'})
        }
      } else {
        context.commit('changeMessage', {message: 'Please log in before making a post!'})
      }
    },
  }
}

export default createStore({
  state: {
    authToken: sessionStorage.getItem('token'),
    isAuth: sessionStorage.getItem('auth'),
    userId: sessionStorage.getItem('userId'),
    username: sessionStorage.getItem('username'),
    errorMessage: ''
  },
  getters: {
    getAuthToken(state) {
      return state.authToken
    },
    getIsAuth(state) {
      return state.isAuth
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
      sessionStorage.setItem('token', payload.token)
      sessionStorage.setItem('auth', true)
      sessionStorage.setItem('userId', payload.userId)
      sessionStorage.setItem('username', payload.username)
      
      state.authToken = sessionStorage.getItem('token')
      state.isAuth = sessionStorage.getItem('auth')
      state.userId = sessionStorage.getItem('userId')
      state.username = sessionStorage.getItem('username')
    },
    logoutUser (state) {
      sessionStorage.clear()

      state.authToken = sessionStorage.getItem('token')
      state.isAuth = sessionStorage.getItem('auth')
      state.userId = sessionStorage.getItem('userId')
      state.username = sessionStorage.getItem('username')
    },
    changeMessage (state, payload) {
      state.errorMessage = payload.message
    }
  },
  actions: {
    onSignUp(context, data) {
      let message = ''
      if(data.username) {
        if(data.password == data.confPass && data.password != undefined) {
          // console.log('username: ' + this.username + ', password: ' + this.password)

          //Create user account
          axios.post('http://localhost:3000/api/auth/signup', {
              username: data.username,
              password: data.password
            }).then((response) => {
              console.log(response)

              //Sign-in user right after account creation
              context.commit('loginUser', {
                token: response.data.token,
                userId: response.data.userId,
                username: data.username
              })

              // axios.post('http://localhost:3000/api/auth/login', {
              //   username: data.username,
              //   password: data.password
              // }).then((response) => {
              //   // console.log(response.data)
              //   context.commit('loginUser', {
              //     token: response.data.token,
              //     userId: response.data.userId,
              //     username: data.username
              //   })
              // }).catch(err => {
              //   console.log(err)
              // })
            }
            ).catch(err => {
              console.log(err)
              message = 'Username already taken!'
              context.commit('changeMessage', {message: message})
            })
        } else {
          message = 'Passwords must match!'
        }
      } else {
        message = 'Username is required!'
      }
      context.commit('changeMessage', {message: message})
    },
    onLogin(context, data) {
      let message = ''
      if(data.username) {
        if(data.password != undefined) {
          // console.log('username: ' + data.username + ', password: ' + data.password)
          axios.post('http://localhost:3000/api/auth/login', {
              username: data.username,
              password: data.password
            }).then((response) => {

              // sessionStorage.setItem('token', response.data.token)
              // sessionStorage.setItem('userId', response.data.userId)
              // sessionStorage.setItem('username', data.username)
              // sessionStorage.setItem('auth', true)
              // console.log(response.data)
              context.commit('loginUser', {
                token: response.data.token,
                userId: response.data.userId,
                username: response.data.username
              })
            }).catch(err => {
              console.log(err)
              message = 'Login failed!'
              context.commit('changeMessage', {message: message})
            })
        } else {
          message = 'Invalid Password!'
        }
      } else {
        message = 'Username required!'
      }
      context.commit('changeMessage', {message: message})
    },
    onLogOut(context) {
      context.commit('logoutUser')
    },
    resetPage(context) {
      context.commit('changeMessage', {message: ''})
    }
  },
  modules: {
    commentModule
  }
})
