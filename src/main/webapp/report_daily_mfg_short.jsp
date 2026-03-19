<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="mr" ng-app="mfgShortApp">
<head>
    <meta charset="UTF-8">
    <title>डेली क्रशींग रिपोर्ट (संक्षिप्त)</title>
    
    <style>
        /* --- PRINT CSS OVERRIDES --- */
        @media print {
            .no-print, .alert, nav, header, footer { 
                display: none !important; 
            }
            body, html {
                background-color: #ffffff !important;
                margin: 0 !important;
                padding: 0 !important;
            }
            #printableArea { 
                position: relative !important;
                left: 0 !important;
                top: 0 !important;
                width: 100% !important; 
                box-shadow: none !important; 
                border: none !important; 
                margin: 0 !important; 
                padding: 0 !important;
                display: block !important;
            }
            .pdf-table { width: 100% !important; border-collapse: collapse !important; }
            .pdf-table th, .pdf-table td { border: 1px solid #000 !important; color: #000 !important; }
            .pdf-table th { 
                background-color: #f1f5f9 !important; 
                -webkit-print-color-adjust: exact !important; 
                print-color-adjust: exact !important; 
            }
        }
        
        /* --- SCREEN & REPORT STYLING --- */
        .marathi-font { font-family: 'Mangal', 'Arial Unicode MS', sans-serif; }
        .report-header-title { font-size: 20px; font-weight: 800; text-align: center; color: #000; }
        .report-header-subtitle { font-size: 16px; font-weight: bold; text-align: center; margin-bottom: 20px; text-decoration: underline; }
        .report-meta-info { display: flex; justify-content: space-between; font-weight: bold; margin-bottom: 10px; font-size: 14px; color: #000; }
        
        .pdf-table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        .pdf-table th, .pdf-table td { border: 1px solid #000; padding: 5px 8px; font-size: 12px; color: #000; }
        .pdf-table th { background-color: #f8fafc; text-align: center; }
        .val-col { text-align: right; font-family: 'JetBrains Mono', monospace; font-weight: bold; }
        .label-col { font-weight: bold; color: #333; }
        .bg-grey { background-color: #f1f5f9; }
    </style>
</head>
<body class="marathi-font">

    <div class="contentpanel" ng-controller="MfgShortController">
        
        <link href="css/forms.css" rel="stylesheet">
        
        <div class="erp-form-container mt-3 mx-2 bg-white shadow-sm border rounded no-print">
            <div class="erp-form-header text-white px-3 py-2 fw-bold text-uppercase" style="background-color: #3bb4b4;">
                <i class="fa fa-file-text-o me-2"></i> डेली क्रशींग रिपोर्ट (संक्षिप्त)
            </div>
            
            <div class="row align-items-center bg-light p-3 mx-0 border-bottom">
                <div class="col-md-4 d-flex align-items-center">
                    <label class="text-muted small fw-bold text-uppercase me-2 mb-0" style="white-space: nowrap;">तारीख निवडा:</label>
                    <div class="input-group input-group-sm shadow-sm">
                        <input type="text" class="form-control border-primary text-center fw-bold text-primary" 
                               placeholder="DD/MM/YYYY" ng-model="manualDateText" ng-change="syncFromText()" maxlength="10">
                        <input type="date" class="form-control border-primary px-1" 
                               ng-model="searchDate" ng-change="syncFromPicker()" 
                               style="max-width: 40px; cursor: pointer;">
                    </div>
                </div>

                <div class="col-md-5">
                    <button type="button" class="btn btn-sm btn-primary fw-bold px-4 me-2 shadow-sm" ng-click="generateReport()" style="background-color: #6593b4; border: none;">
                        <i class="fa fa-cogs me-1"></i> Generate
                    </button>
                    <button type="button" class="btn btn-sm btn-warning fw-bold px-4 text-white shadow-sm" ng-click="printReport()" style="background-color: #e5a751; border: none;" ng-disabled="!isDataLoaded">
                        <i class="fa fa-print me-1"></i> Print / PDF
                    </button>
                    <button type="button" class="btn btn-sm btn-light fw-bold px-4 border shadow-sm" ng-click="clearReport()">
                        <i class="fa fa-refresh me-1"></i> Reset
                    </button>
                </div>
            </div>
        </div>

        <div class="erp-form-container mx-2 mt-4 p-5 bg-white shadow border rounded" id="printableArea" ng-show="isDataLoaded">
            
            <div class="report-header-title">श्री. छत्रपती सहकारी साखर कारखाना लि., भवानीनगर, ता. इंदापूर जि. पुणे. [cite: 13]</div>
            <div class="report-header-subtitle">डेली क्रशींग रिपोर्ट (एकत्रीत संक्षिप्त अहवाल) [cite: 16, 17]</div>
            
            <div class="report-meta-info">
                <div>क्रॉपडे: {{ reportData.cropDay || '१' }} [cite: 14, 15]</div>
                <div>हंगाम: २०२५-२०२६ [cite: 18]</div>
                <div>दिनांक: {{ displayDate }} [cite: 19]</div>
            </div>

            <table class="pdf-table">
                <thead>
                    <tr>
                        <th rowspan="2" style="width: 5%;">अ. न.</th>
                        <th rowspan="2" style="width: 25%;">तपशील</th>
                        <th rowspan="2" style="width: 15%;">आज</th>
                        <th colspan="2">हंगाम २०२५-२०२६ [cite: 18]</th>
                        <th colspan="2">मागील हंगाम २०२४-२०२५</th>
                    </tr>
                    <tr>
                        <th style="width: 15%;">आजपर्यंत</th>
                        <th style="width: 10%;">%</th>
                        <th style="width: 15%;">आज</th>
                        <th style="width: 15%;">आजपर्यंत</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="text-center" rowspan="5">१</td>
                        <td class="label-col bg-grey">ऊस गळीत (मे. टन)</td>
                        <td class="bg-grey"></td><td class="bg-grey"></td><td class="bg-grey"></td><td class="bg-grey"></td><td class="bg-grey"></td>
                    </tr>
                    <tr>
                        <td>सभासद</td>
                        <td class="val-col">{{ reportData.caneMemberToday | number:3 }}</td>
                        <td class="val-col">{{ reportData.caneMemberTodate | number:3 }}</td>
                        <td></td><td>-</td><td>-</td>
                    </tr>
                    <tr>
                        <td>बि. सभासद</td>
                        <td class="val-col">{{ reportData.caneNonMemberToday | number:3 }}</td>
                        <td class="val-col">{{ reportData.caneNonMemberTodate | number:3 }}</td>
                        <td></td><td>-</td><td>-</td>
                    </tr>
                    <tr>
                        <td>इतर</td>
                        <td class="val-col">{{ reportData.caneOtherToday | number:3 }}</td>
                        <td class="val-col">{{ reportData.caneOtherTodate | number:3 }}</td>
                        <td></td><td>-</td><td>-</td>
                    </tr>
                    <tr class="bg-grey">
                        <td class="label-col">एकूण</td>
                        <td class="val-col">{{ reportData.caneTotalToday | number:3 }}</td>
                        <td class="val-col">{{ reportData.caneTotalTodate | number:3 }}</td>
                        <td></td><td>-</td><td>-</td>
                    </tr>

                    <tr>
                        <td class="text-center" rowspan="5">२</td>
                        <td class="label-col bg-grey">साखर पोती (क्विंटल)</td>
                        <td class="bg-grey"></td><td class="bg-grey"></td><td class="bg-grey"></td><td class="bg-grey"></td><td class="bg-grey"></td>
                    </tr>
                    <tr>
                        <td>एल-३०</td>
                        <td class="val-col">{{ reportData.sugarL30Today | number:2 }}</td>
                        <td class="val-col">{{ reportData.sugarL30Todate | number:2 }}</td>
                        <td></td><td>-</td><td>-</td>
                    </tr>
                    <tr>
                        <td>एम-३०</td>
                        <td class="val-col">{{ reportData.sugarM30Today | number:2 }}</td>
                        <td class="val-col">{{ reportData.sugarM30Todate | number:2 }}</td>
                        <td></td><td>-</td><td>-</td>
                    </tr>
                    <tr>
                        <td>एस १-३०</td>
                        <td class="val-col">{{ reportData.sugarS130Today | number:2 }}</td>
                        <td class="val-col">{{ reportData.sugarS130Todate | number:2 }}</td>
                        <td></td><td>-</td><td>-</td>
                    </tr>
                    <tr class="bg-grey">
                        <td class="label-col">एकूण</td>
                        <td class="val-col">{{ reportData.sugarTotalToday | number:2 }}</td>
                        <td class="val-col">{{ reportData.sugarTotalTodate | number:2 }}</td>
                        <td></td><td>-</td><td>-</td>
                    </tr>
                </tbody>
            </table>

            <table class="pdf-table">
                <tbody>
                    <tr>
                        <td style="width: 50%;">कंडेन्सर पाणी तापमान इनलेट: <b>{{ reportData.inletTemp }}°C</b></td>
                        <td style="width: 50%;">कंडेन्सर पाणी तापमान आउटलेट: <b>{{ reportData.outletTemp }}°C</b></td>
                    </tr>
                    <tr>
                        <td>रिकव्हरी % ऊस: <b>{{ reportData.recoveryPct }}%</b></td>
                        <td>को-जनरेशन युनिट्स: <b>{{ reportData.cogenUnits }}</b></td>
                    </tr>
                </tbody>
            </table>

            <div style="margin-top: 60px; display: flex; justify-content: space-between; text-align: center; font-weight: bold; font-size: 14px;">
                <div style="width: 30%;">लॅब इनचार्ज [cite: 30]</div>
                <div style="width: 30%;">चीफ केमिस्ट [cite: 31]</div>
                <div style="width: 30%;">मॅनेजिंग डायरेक्टर</div>
            </div>

        </div>

        <div class="alert alert-light w-75 mx-auto text-center border shadow-sm mt-5 text-muted no-print" ng-hide="isDataLoaded">
            <i class="fa fa-info-circle fa-2x mb-3 text-primary d-block"></i>
            <h6 class="fw-bold">अहवाल उपलब्ध नाही</h6>
            <p class="small mb-0">कृपया तारीख निवडा आणि <strong>Generate</strong> वर क्लिक करा.</p>
        </div>

    </div>

    <script src="js/reportMfgShort.js"></script>

</body>
</html>