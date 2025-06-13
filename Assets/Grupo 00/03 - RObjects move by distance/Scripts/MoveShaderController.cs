using UnityEngine;
using UnityEngine.UI;

public class MoveShaderController : MonoBehaviour
{
    [SerializeField] private Material moveMaterial;
    [SerializeField] private Slider heightSlider;
    [SerializeField] private Slider frequencySlider;
    [SerializeField] private Slider speedSlider;

    private void Start()
    {
        if (moveMaterial != null)
        {
            heightSlider?.onValueChanged.AddListener(val => moveMaterial.SetFloat("_MoveHeight", val));
            frequencySlider?.onValueChanged.AddListener(val => moveMaterial.SetFloat("_MoveFrequency", val));
            speedSlider?.onValueChanged.AddListener(val => moveMaterial.SetFloat("_MoveSpeed", val));
        }
    }
}
