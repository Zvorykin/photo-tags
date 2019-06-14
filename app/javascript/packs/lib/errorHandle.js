export default async (app, cb, showLoading = true) => {
  if ((app.loading === false) && showLoading) app.loading = true

  let res
  try {
    res = await cb()
  } catch (err) {
    const { statusText, status, body, data } = err.response || {}

    app.$q.notify({
      message: `Error ${ status || '' }: ${ statusText || '' } \n${ body || '' }\n${ data || '' }`
    })

    throw err
  }

  if (app.loading) app.loading = false
  return res && res.data
}
