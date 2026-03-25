@echo off
setlocal enabledelayedexpansion

set "DLTC=%~dp0..\..\dltc.bat"
set "PASS=0"
set "FAIL=0"
set "TOTAL=0"
set "RESULTS="

echo =========================================
echo    NEW Feature Tests
echo =========================================
echo.

for %%f in (test_17_type_alias test_18_nullable test_19_collections test_20_foreach test_21_static test_22_access_modifiers test_23_fun_pointers test_24_variadic test_25_context_blocks test_26_async test_27_stack_alloc test_28_nested_access test_29_super_method test_30_reverse_loop test_31_advanced_match test_32_list_methods test_33_nested_collections) do (
    set /a TOTAL+=1
    echo --- Testing: %%f ---
    call "%DLTC%" "%%f.dlt" -o "%%f.exe" --keep-mlir 2>&1
    if errorlevel 1 (
        echo [FAIL] %%f - COMPILE ERROR
        set /a FAIL+=1
        set "RESULTS=!RESULTS!FAIL-COMPILE %%f|"
    ) else (
        echo [COMPILED] Running...
        .\%%f.exe
        if errorlevel 1 (
            echo [FAIL] %%f - RUNTIME ERROR
            set /a FAIL+=1
            set "RESULTS=!RESULTS!FAIL-RUNTIME %%f|"
        ) else (
            echo [PASS] %%f
            set /a PASS+=1
            set "RESULTS=!RESULTS!PASS %%f|"
        )
    )
    echo.
)

echo =========================================
echo    Results: !PASS!/!TOTAL! passed, !FAIL! failed
echo =========================================
echo.
echo Summary:
for %%r in ("!RESULTS:|=" "!") do (
    if not "%%~r"=="" echo   %%~r
)

endlocal
