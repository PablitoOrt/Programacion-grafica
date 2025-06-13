using UnityEngine;
using UnityEngine.UI;

public class DistanceShaderController : MonoBehaviour
{
    [SerializeField] private Material distanceMaterial;
    [SerializeField] private Slider heightSlider;
    [SerializeField] private Slider frequencySlider;

    private void Start()
    {
        if (distanceMaterial != null)
        {
            heightSlider?.onValueChanged.AddListener(val => distanceMaterial.SetFloat("_DisHeight", val));
            frequencySlider?.onValueChanged.AddListener(val => distanceMaterial.SetFloat("_DisFrequency", val));
        }
    }
}
