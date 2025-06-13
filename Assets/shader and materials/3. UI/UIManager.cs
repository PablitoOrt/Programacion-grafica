using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    [Header("Distortion Shader")]
    public Material lensDistortionMaterial;
    public Slider distortSlider;

    void Start()
    {
        distortSlider.onValueChanged.AddListener((value) => lensDistortionMaterial.SetFloat("_Distort", value));
    }
}
