export default async (app, cb, showLoading = true) => {
  if ((app.loading === false) && showLoading) app.loading = true

  let res
  try {
    res = await cb()
  } catch (err) {
    console.error(err)

    // app.$Loading.error()

    const {
      statusText: error,
      status: code,
      body: message,
      data,
    } = err.response || {}

    console.dir(err.stack)

    const title = `Error ${ code || '' }: ${ error || '' }`
    const content = `${ data } \n
       ${ err.exception || '' } ${ message || '' } ${ err.message }`.trim()

    // app.$Modal.error({ title, content })
  }

  if (app.loading) app.loading = false
  return res && res.data
}
