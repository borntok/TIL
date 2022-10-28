import { useState, useEffect } from "react";
import { useQuery } from "react-query";
import axios from "axios";
import { GITHUB_API } from "./api";

interface UseForm {
  initialValues: Record<string, string>;
  validate: (value: Record<string, string>) => Record<string, string>;
  refs: Record<string, React.MutableRefObject<HTMLInputElement>>;
  onSuccess: (result: string) => void;
  onErrors: () => void;
  onSubmit: () => Promise<string>;
}

export function useForm({
  initialValues,
  validate,
  refs,
  onSuccess,
  onErrors,
  onSubmit,
}: UseForm) {
  const [inputValues, setInputValues] = useState(initialValues);
  const [errors, setErrors] = useState({});
  const [isSubmitting, setIsSubmitting] = useState(false);

  function onChange(e: React.ChangeEvent<{ name: string; value: string }>) {
    const { name, value } = e.target;
    setInputValues({ ...inputValues, [name]: value });
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();

    setIsSubmitting(true);
    const validateResult = validate(inputValues);
    setErrors(validateResult);

    const errorKeys = Object.keys(validateResult);

    if (errorKeys.length !== 0) {
      const key = errorKeys[0];
      alert(validateResult[key]);
      refs[key].current.focus();

      setIsSubmitting(false);
      return;
    }

    if (errorKeys.length === 0) {
      try {
        const result = await onSubmit();
        onSuccess(result);
      } catch {
        onErrors();
      }
      return;
    }
  }

  return {
    inputValues,
    onChange,
    isSubmitting,
    errors,
    handleSubmit,
  };
}

async function getUserInfo() {
  const data = await axios.get(`${GITHUB_API}/user`, {
    headers: {
      Authorization: process.env.REACT_APP_GITHUB_TOKEN!,
      "Content-Type": "application/json",
    },
  });

  return data.data;
}

export function useUser() {
  return useQuery(["userInfo"], () => getUserInfo());
}
