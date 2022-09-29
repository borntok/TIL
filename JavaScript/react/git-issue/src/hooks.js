import { useState } from "react"

export function useForm({
  initialValues,
  validate,
  refs,
  onSuccess, // 성공했을때 무엇을 할 건지?
  onErrors, // 에러가 났을 때 어떻게 할 지?
  onSubmit, // 값이 제출될 때 어떤 함수를 호출할 지?
}) {
  const [inputValues, setInputValues] = useState(initialValues)
  const [errors, setErrors] = useState({})
  const [isSubmitting, setIsSubmitting] = useState(false)

  function onChange(e) {
    const { name, value } = e.target
    setInputValues({ ...inputValues, [name]: value })
  }

  function handleSubmit(e) {
    e.preventDefault()

    setIsSubmitting(true)
    const validateResult = validate(inputValues)
    setErrors(validateResult)

    const errorKeys = Object.keys(validateResult)

    if (errorKeys.length !== 0) {
      const key = errorKeys[0]
      alert(validateResult[key])
      refs[key].current.focus()

      setIsSubmitting(false)
      return
    }

    if (errorKeys.length === 0) {
      onSubmit()
      return
    }
  }

  return {
    inputValues,
    onChange,
    isSubmitting,
    errors,
    handleSubmit,
  }
}
