using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Camera))]

public class PostProcessing : MonoBehaviour
{

    [SerializeField] Material GrayScaleMaterial;

    [SerializeField] Slider grayScaleSlider;


    private void Start()
    {
        grayScaleSlider.onValueChanged.AddListener(UpdateGrayScaleValue);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, GrayScaleMaterial);
    }

    private void UpdateGrayScaleValue(float value)
    {
        GrayScaleMaterial.SetFloat("_intensity", value) ;
    }

}
