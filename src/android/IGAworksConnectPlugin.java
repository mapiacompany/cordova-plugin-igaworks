/*
       Licensed to the Apache Software Foundation (ASF) under one
       or more contributor license agreements.  See the NOTICE file
       distributed with this work for additional information
       regarding copyright ownership.  The ASF licenses this file
       to you under the Apache License, Version 2.0 (the
       "License"); you may not use this file except in compliance
       with the License.  You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing,
       software distributed under the License is distributed on an
       "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
       KIND, either express or implied.  See the License for the
       specific language governing permissions and limitations
       under the License.
 */

package org.apache.cordova.igaworks;

import android.content.Intent;
import android.graphics.Color;

import com.igaworks.IgawCommon;
import com.igaworks.adpopcorn.IgawAdpopcorn;
import com.igaworks.adpopcorn.style.ApStyleManager;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;

import java.util.HashMap;

public class IGAworksConnectPlugin extends CordovaPlugin {
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("setUserID")) {
            String message = args.getString(0);
            if (message != null && message.length() > 0) {
                IgawCommon.setUserId(this.cordova.getActivity(), message);
                callbackContext.success(message);
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }
            return true;
        }
        if (action.equals("openOfferWall")) {
            IgawAdpopcorn.openOfferWall(this.cordova.getActivity());
            callbackContext.success("success");
            return true;
        }
        if (action.equals("openDialogTypeOfferWall")) {
            IgawAdpopcorn.openDialogTypeOfferWall(this.cordova.getActivity());
            callbackContext.success("success");
            return true;
        }
        if (action.equals("showVideoAd")) {
            // IgawAdpopcorn.showVideoAd(this, new IAPShowVideoAdEventListener() {
            //     @Override
            //     public void OnShowVideoAdSuccess() {
            //         // Video Showing Succeeded
            //     }

            //     @Override
            //     public void OnShowVideoAdFailure(APVideoError apVideoError) {
            //         // Video Showing Failed
            //         // ErrorCode 
            //         //      TERMINATED_OR_INVALID_CAMPAIGN =  980;
            //         //      TERMINATED_OR_INVALID_CAMPAIGN =  999;
            //         //      ALREADY_COMPLETED_CAMPAIGN =  2000;
            //     }

            //     @Override
            //     public void OnVideoAdClose() {
            //         // VideoAd Closed
            //     }
            // });
        }
        return false;
    }

    @Override
    public void onResume(boolean multitasking) {
        IgawCommon.startSession(this.cordova.getActivity());

        // 스타일 옵션 HashMap 생성
        HashMap<String, Object> optionMap = new HashMap<>();
        // 컬러코드는 RGB(ex : #RRGGBB)와 16진수(ex : 0xffee5555) 형식을 지원
        // 오퍼월 테마 컬러 변경
        optionMap.put(ApStyleManager.CustomStyle.OFFERWALL_THEME_COLOR, Color.parseColor("#2d2c2d"));

        optionMap.put(ApStyleManager.CustomStyle.TOP_BAR_TEXT_SIZE_DP, 18);
        optionMap.put(ApStyleManager.CustomStyle.TOP_BAR_TEXT_COLOR, Color.parseColor("#ffffff"));
        // 오퍼월 탑바 배경 컬러 변경
        optionMap.put(ApStyleManager.CustomStyle.TOP_BAR_BG_COLOR, Color.parseColor("#000000"));

        optionMap.put(ApStyleManager.CustomStyle.OFFERWALL_TITLE_TEXT, "광고 참여하고 캐시 무료 충전");
        // 오퍼월 탑바 쉐도우 효과 변경
        optionMap.put(ApStyleManager.CustomStyle.TOP_BAR_SHADOW, true);
        optionMap.put(ApStyleManager.CustomStyle.BOTTOM_BAR_BG_COLOR, Color.parseColor("#f7f7f7"));
        optionMap.put(ApStyleManager.CustomStyle.BOTTOM_BAR_TEXT_COLOR, Color.parseColor("#7b7b7b"));
        // 세팅된 스타일 옵션 HashMap을 적용
        ApStyleManager.setCustomOfferwallStyle(optionMap);
    }

    @Override
    public void onPause(boolean multitasking) {
        IgawCommon.endSession();
    }
}
