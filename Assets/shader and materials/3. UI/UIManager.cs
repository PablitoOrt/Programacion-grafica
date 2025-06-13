using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    [Header("Distortion Shader")]
    public Material lensDistortionMaterial;
    public Slider distortSlider;

    [Header("Burn Shader")]
    public Material burnMaterial;
    public Slider burnSlider;

    void Start()
    {
        distortSlider.onValueChanged.AddListener((value) => lensDistortionMaterial.SetFloat("_Distort", value));

        burnSlider.onValueChanged.AddListener((value) => burnMaterial.SetFloat("_BurnStart", value));
        burnSlider.onValueChanged.AddListener((value) => burnMaterial.SetFloat("_BurnStrength", value));

    }
}
